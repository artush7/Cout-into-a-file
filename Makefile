#Clang
CXX = clang++ -std=c++23
CXXFLAGS = -Wall -Wextra -g -Wunreachable-code -Wunreachable-code-loop-increment -Wunreachable-code-return

#Directories
SRC_DIR = src
BUILD_DIR = build
TEST_DIR = tests

#Source Files
SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRC_FILES))

#Test files
TEST_FILES = $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(TEST_FILES))

#Executable files
TEST_EXEC = $(BUILD_DIR)/runTests

#includes
INCLUDES = -I$(SRC_DIR)

#Library flags
LIBS = -lgtest -lgtest_main -pthread

all:$(TEST_EXEC)

#Create directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

#Compile source files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

#Compile test files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

#Create executable file
$(TEST_EXEC):$(OBJ_FILES) $(TEST_OBJ_FILES) | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $^ -o $@ $(LIBS)

#Run 
test:$(TEST_EXEC)
	./$(TEST_EXEC)

#remove all files in build
clean:
	rm -rf $(BUILD_DIR)

.PHONY:all clean test